unit NOT_FINISHED_vcmDropDownMenuForChromeLike;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\NOT_FINISHED_vcmDropDownMenuForChromeLike.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , vcmBaseMenuForChromeLike
;

type
 TvcmDropDownMenuForChromeLike = class(TvcmBaseMenuForChromeLike)
 end;//TvcmDropDownMenuForChromeLike
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , vcmMenuForChromeLikeItems
 {$If NOT Defined(NoVCL)}
 , ShadowWnd
 {$IfEnd} // NOT Defined(NoVCL)
 , multimon
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
