unit VCMTest_ChromeLike_TestUnit;

// Модуль: "w:\common\components\gui\Garant\VCM\VCMTest_ChromeLike_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "ChromeLike" MUID: (53D125AE02CB)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , vcmBaseMenuForChromeLike_p
 , ChromeLikeTabSetControl_p
 , ChromeLikeTab_p
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
