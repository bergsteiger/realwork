program ReleaseDailyTest;
 {* ���������� ����� ����� ���������� ��������� (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleaseDailyTest.dpr"
// ���������: "TestTarget"

{$Include DailyTest.inc}

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
