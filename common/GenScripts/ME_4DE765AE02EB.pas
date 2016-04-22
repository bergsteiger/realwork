unit ArchiInsiderTests_TestLibrary;
 {* Первые тесты Архивариуса }

// Модуль: "w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "ArchiInsiderTests" MUID: (4DE765AE02EB)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , ArchiInsiderTests_EditorTests_TestUnit
 , ArchiInsiderTests_DialogTest_TestUnit
 , ArchiInsiderTests_FilterTests_TestUnit
 , ArchiInsiderTests_MacrosTest_TestUnit
 , ArchiInsiderTests_ContentsTree_TestUnit
 , ArchiInsiderTests_SBSTests_TestUnit
 , ArchiInsiderTests_TableTools_TestUnit
 , ArchiInsiderTests_OEMTextTests_TestUnit
 , ArchiInsiderTests_BlockTest_TestUnit
 , ArchiInsiderTests_ScrollTests_TestUnit
 , ArchiInsiderTests_SelectionTests_TestUnit
 , ArchiInsiderTests_KeyWordsTest_TestUnit
 , ArchiInsiderTests_Drawing_Tests_TestUnit
 , ArchiInsiderTests_Text2TableTests_TestUnit
 , ArchiInsiderTests_TableBoundariesAlignment_TestUnit
 , ArchiInsiderTests_InnerTable_TestUnit
 , ArchiInsiderTests_ColumnResize_TestUnit
 , ArchiInsiderTests_TableResize_TestUnit
 , ArchiInsiderTests_DataBaseSave_TestUnit
 , ArchiInsiderTests_LoadText_TestUnit
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
