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
 , nscNavigatorPageControl_p
 , eeTreeViewExport_p
 , nscSimpleEditor_p
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
