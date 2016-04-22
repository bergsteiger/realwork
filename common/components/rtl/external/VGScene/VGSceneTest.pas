unit VGSceneTest;

// Модуль: "w:\common\components\rtl\external\VGScene\VGSceneTest.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "VGSceneTest" MUID: (536B6A5E0136)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , VGSceneTest_Impl_TestUnit
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)

end.
