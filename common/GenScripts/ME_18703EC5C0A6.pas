program ReleaseNewGenTest;
 {* ����� ��� ��� �� ������ ���������� (�������� �������) }

// ������: "w:\MDProcess\NewGenTest\ReleaseNewGenTest.dpr"
// ���������: "TestTarget"

{$Include w:\MDProcess\NewGenTest\NewGenTest.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(NewGen)

end.
