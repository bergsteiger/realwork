program ArchiTest;
 {* ����� ���� }

// ������: "w:\archi\source\projects\Archi\ArchiTest.dpr"
// ���������: "TestTarget"
// ������� ������: "Archi" MUID: (4DE4A1D0031E)

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
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
