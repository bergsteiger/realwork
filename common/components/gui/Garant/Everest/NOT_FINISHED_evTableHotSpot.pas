unit NOT_FINISHED_evTableHotSpot;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTableHotSpot.pas"
// ���������: "SimpleClass"
// ������� ������: "TevTableHotSpot" MUID: (4D640655011C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evSelectingHotSpot
 , evParaListHotSpotTester
;

type
 TevTableHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableHotSpotTester

 TevTableHotSpot = class(TevSelectingHotSpot)
 end;//TevTableHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , Table_Const
;

type
 TableTagFriend = {abstract} class(TableTagClass)
  {* ���� � ������ TableTag }
 end;//TableTagFriend
{$IfEnd} // Defined(evNeedHotSpot)

end.
