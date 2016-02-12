unit NOT_FINISHED_evReqCellHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evReqCellHotSpot.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evTableCellHotSpot
;

type
 {$If NOT Defined(evCanEditControlsAsText)}
 TevReqCellHotSpotTester = class(TevTableCellHotSpotTester)
 end;//TevReqCellHotSpotTester
 {$IfEnd} // NOT Defined(evCanEditControlsAsText)

{$IfEnd} // Defined(evNeedHotSpot)
implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;

{$If NOT Defined(evCanEditControlsAsText)}
{$IfEnd} // NOT Defined(evCanEditControlsAsText)
{$IfEnd} // Defined(evNeedHotSpot)
end.
