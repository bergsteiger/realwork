unit F1Test;
 {* Сборник тестов для оболочки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1Test.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "F1Test" MUID: (499AEC6A0372)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , F1Test_Tree_TestUnit
 , EverestTest
 , VTTest
 {$If NOT Defined(NoVCM)}
 , VCMTest
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , NemesisTest
 {$IfEnd} // Defined(Nemesis)
 , AFWTest
 {$If NOT Defined(NoVGScene)}
 , VGSceneTest
 {$IfEnd} // NOT Defined(NoVGScene)
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // NOT Defined(XE)

end.
