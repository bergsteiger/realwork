unit VCMTest;
 {* Тесты VCM }

// Модуль: "w:\common\components\gui\Garant\VCM\VCMTest.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "VCMTest" MUID: (499AA43A012F)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmProfilersCollection_p
 {$If NOT Defined(NoTabs)}
 , RectWrap
 {$IfEnd} // NOT Defined(NoTabs)
 {$If NOT Defined(NoTabs)}
 , vcmMenuForChromeLikeItemWrap
 {$IfEnd} // NOT Defined(NoTabs)
 {$If NOT Defined(NoTabs)}
 , vcmBaseMenuForChromeLike_p
 {$IfEnd} // NOT Defined(NoTabs)
 {$If NOT Defined(NoTabs)}
 , ChromeLikeTabSetControl_p
 {$IfEnd} // NOT Defined(NoTabs)
 {$If NOT Defined(NoTabs)}
 , ChromeLikeTab_p
 {$IfEnd} // NOT Defined(NoTabs)
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

end.
