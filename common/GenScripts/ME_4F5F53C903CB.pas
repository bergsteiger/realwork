program NewGenTest;
 {* ����� ��� ��� �� ������ ���������� }

// ������: "w:\MDProcess\NewGenTest\NewGenTest.dpr"
// ���������: "TestTarget"

{$Include NewGenTest.inc}

interface

{$If Defined(NewGen) AND Defined(nsTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(NewGen) AND Defined(nsTest)

implementation

{$If Defined(NewGen) AND Defined(nsTest)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(NewGen) AND Defined(nsTest)

end.
