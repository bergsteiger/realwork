unit TestForTFW_TestLibrary;
 {* ����� ��� ������������ ���������� ��������� ���������� TFW }

// ������: "w:\common\components\rtl\Garant\TestForTFW\TestForTFW_TestLibrary.pas"
// ���������: "TestLibrary"
// ������� ������: "TestForTFW" MUID: (4CA0B1CA00A3)

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
 , SuccessTest
 , FailedTest
 , K235868845
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
