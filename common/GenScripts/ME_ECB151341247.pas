program ReleaseTFWTest;
 {* ����� ��� ������������ ���������� ��������� ���������� TFW (�������� �������) }

// ������: "w:\common\components\TFWTest\ReleaseTFWTest.dpr"
// ���������: "TestTarget"
// ������� ������: "ReleaseTFW" MUID: (ECB151341247)

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
