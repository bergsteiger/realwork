unit NOT_FINISHED_vcmMainMenuStripForChromeLike;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\NOT_FINISHED_vcmMainMenuStripForChromeLike.pas"
// ���������: "GuiControl"
// ������� ������: "TvcmMainMenuStripForChromeLike" MUID: (545C521A0358)

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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmMainMenuStripForChromeLike);
 {* ����������� TvcmMainMenuStripForChromeLike }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
