unit Tasks_Registering_TestUnit;

// ������: "w:\archi\source\projects\Archi\Tests\Tasks_Registering_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Registering" MUID: (53BC00030264)

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
 , RegisteredTasksTest
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
