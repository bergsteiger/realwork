program TFWTest;
 {* ����� ��� ������������ ���������� ��������� ���������� TFW }

// ������: "w:\common\components\TFWTest\TFWTest.dpr"
// ���������: "TestTarget"

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
