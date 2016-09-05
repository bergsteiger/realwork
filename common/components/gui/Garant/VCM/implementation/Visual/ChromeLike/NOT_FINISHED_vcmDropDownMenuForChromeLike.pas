unit NOT_FINISHED_vcmDropDownMenuForChromeLike;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\NOT_FINISHED_vcmDropDownMenuForChromeLike.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvcmDropDownMenuForChromeLike" MUID: (545C51F90170)

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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *545C51F90170impl_uses*
 //#UC END# *545C51F90170impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDropDownMenuForChromeLike);
 {* Регистрация TvcmDropDownMenuForChromeLike }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
