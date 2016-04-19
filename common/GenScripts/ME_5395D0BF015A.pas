unit New_Actions_Test_TestLibrary;
 {* Тесты для "новой коммуникации" через TcsAction }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\New_Actions_Test_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "New Actions Test" MUID: (5395D0BF015A)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , archiExportActionTest
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
