unit NOT_FINISHED_vcmBaseMenuForChromeLike;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\NOT_FINISHED_vcmBaseMenuForChromeLike.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvcmBaseMenuForChromeLike" MUID: (545C51CB0171)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;

type
 TvcmBaseMenuForChromeLike = class
 end;//TvcmBaseMenuForChromeLike
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , vcmMenuForChromeLikeItems
 , vcmMainMenuForChromeLikeTypes
 {$If NOT Defined(NoScripts)}
 , vcmTabbedMenuWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *545C51CB0171impl_uses*
 //#UC END# *545C51CB0171impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseMenuForChromeLike);
 {* Регистрация TvcmBaseMenuForChromeLike }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
