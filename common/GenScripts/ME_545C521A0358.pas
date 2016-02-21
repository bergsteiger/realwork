unit NOT_FINISHED_vcmMainMenuStripForChromeLike;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\NOT_FINISHED_vcmMainMenuStripForChromeLike.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , vcmBaseMenuForChromeLike
;

type
 TvcmMainMenuStripForChromeLike = class(TvcmBaseMenuForChromeLike)
 end;//TvcmMainMenuStripForChromeLike
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , vcmMenuForChromeLikeItems
 , vcmDropDownMenuForChromeLike
 , vcmPopupControlWindowService
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
