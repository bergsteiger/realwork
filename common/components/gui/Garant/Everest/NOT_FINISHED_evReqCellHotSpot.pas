unit NOT_FINISHED_evReqCellHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evReqCellHotSpot.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evReqCellHotSpot" MUID: (53D0C11D034F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evTableCellHotSpot
;

{$If NOT Defined(evCanEditControlsAsText)}
type
 TevReqCellHotSpotTester = class(TevTableCellHotSpotTester)
 end;//TevReqCellHotSpotTester
{$IfEnd} // NOT Defined(evCanEditControlsAsText)

{$IfEnd} // Defined(evNeedHotSpot)
implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 //#UC START# *53D0C11D034Fimpl_uses*
 //#UC END# *53D0C11D034Fimpl_uses*
;

{$If NOT Defined(evCanEditControlsAsText)}
{$IfEnd} // NOT Defined(evCanEditControlsAsText)
{$IfEnd} // Defined(evNeedHotSpot)
end.
