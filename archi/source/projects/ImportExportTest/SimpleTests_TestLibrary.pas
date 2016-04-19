unit SimpleTests_TestLibrary;

// Модуль: "w:\archi\source\projects\ImportExportTest\SimpleTests_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "SimpleTests" MUID: (55ED4FE10372)

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
 , ExportToSeparateNSRTest
 , ExportToSingleNSRTest
 , ExportSeparatedByMainTest
 , ExportSeparatedBySizeTest
 , ExportByMainRelNamedTest
 , ExportBySizeAndMain
;
{$IfEnd} // Defined(nsTest)

end.
