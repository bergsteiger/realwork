unit ImportExportTestLibrary_TestLibrary;

// Модуль: "w:\archi\source\projects\ImportExportTest\ImportExportTestLibrary_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "ImportExportTestLibrary" MUID: (519465D90095)

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , ImportExportTestLibrary_ImportExport_TestUnit
;
{$IfEnd} // Defined(nsTest)

end.
