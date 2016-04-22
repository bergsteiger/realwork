unit NemesisTest;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NemesisTest.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "NemesisTest" MUID: (499ABFAA038C)

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
 , NemesisTest_Navigator_TestUnit
 , NemesisTest_Tree_TestUnit
 , NemesisTest_Editor_TestUnit
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
