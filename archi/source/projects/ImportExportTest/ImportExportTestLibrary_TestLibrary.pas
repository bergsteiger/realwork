unit ImportExportTestLibrary_TestLibrary;

// ������: "w:\archi\source\projects\ImportExportTest\ImportExportTestLibrary_TestLibrary.pas"
// ���������: "TestLibrary"
// ������� ������: "ImportExportTestLibrary" MUID: (519465D90095)

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
