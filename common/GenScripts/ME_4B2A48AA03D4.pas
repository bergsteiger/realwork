program DailyTest;
 {* ���������� ����� ����� ���������� ��������� }

// ������: "w:\common\components\DailyTest\DailyTest.dpr"
// ���������: "TestTarget"
// ������� ������: "Daily" MUID: (4B2A48AA03D4)

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
