program ReleaseNewGenTest;
 {* ����� ��� ��� �� ������ ���������� (�������� �������) }

// ������: "w:\MDProcess\NewGenTest\ReleaseNewGenTest.dpr"
// ���������: "TestTarget"
// ������� ������: "ReleaseNewGen" MUID: (18703EC5C0A6)

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
