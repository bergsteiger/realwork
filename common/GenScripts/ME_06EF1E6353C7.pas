program ReleaseDailyTest;
 {* ���������� ����� ����� ���������� ��������� (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleaseDailyTest.dpr"
// ���������: "TestTarget"
// ������� ������: "ReleaseDaily" MUID: (06EF1E6353C7)

{$Include w:\common\components\DailyTest\DailyTest.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
