unit DailyTest_Core_TestUnit;

// ������: "w:\common\components\rtl\Garant\Daily\DailyTest_Core_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Core" MUID: (4B2A15A00031)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
 , TestMMX
 , TestFilerReadLn
 , TestFilerCopyViaReadLn
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
