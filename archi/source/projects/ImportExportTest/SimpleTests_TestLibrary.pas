unit SimpleTests_TestLibrary;

// ������: "w:\archi\source\projects\ImportExportTest\SimpleTests_TestLibrary.pas"
// ���������: "TestLibrary"
// ������� ������: "SimpleTests" MUID: (55ED4FE10372)

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
 , SimpleTests_ExportPipeTests_TestUnit
;
{$IfEnd} // Defined(nsTest)

end.
