unit NOT_FINISHED_evControlsBlockHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evControlsBlockHotSpotTester.pas"
// ���������: "SimpleClass"
// ������� ������: "TevControlsBlockHotSpotTester" MUID: (4A27B53100B6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
uses
 l3IntfUses
 , evControlsBlockHotSpotTesterPrim
;

type
 TevControlsBlockHotSpotTester = class(TevControlsBlockHotSpotTesterPrim)
 end;//TevControlsBlockHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)

implementation

{$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
uses
 l3ImplUses
 , ControlsBlock_Const
;

type
 ControlsBlockTagFriend = {abstract} class(ControlsBlockTagClass)
  {* ���� � ������ ControlsBlockTag }
 end;//ControlsBlockTagFriend

{$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)
end.
