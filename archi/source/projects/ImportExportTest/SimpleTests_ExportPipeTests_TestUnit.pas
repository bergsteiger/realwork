unit SimpleTests_ExportPipeTests_TestUnit;

// Модуль: "w:\archi\source\projects\ImportExportTest\SimpleTests_ExportPipeTests_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "ExportPipeTests" MUID: (55ED516B0072)

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
