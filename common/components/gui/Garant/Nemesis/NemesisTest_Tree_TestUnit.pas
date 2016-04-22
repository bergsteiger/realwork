unit NemesisTest_Tree_TestUnit;
 {* Тесты деревьев }

// Модуль: "w:\common\components\gui\Garant\Nemesis\NemesisTest_Tree_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Tree" MUID: (499C0BD60338)

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
 , eeTreeViewExport_p
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
