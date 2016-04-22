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
 , VCMTest_Profilers_TestUnit
 {$If NOT Defined(NoTabs)}
 , VCMTest_ChromeLike_TestUnit
 {$IfEnd} // NOT Defined(NoTabs)
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

end.
