unit New_Actions_Test_Tasked_Actions_TestUnit;
 {* ����� ��� ��������, ������� ����� ����������� � ������� }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\NewActions\Export\New_Actions_Test_Tasked_Actions_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Tasked Actions" MUID: (5395D0F601A6)

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
