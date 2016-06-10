unit Archi Tests_TestLibrary;

// ������: "w:\common\components\rtl\Garant\Archi_Tests\Archi Tests_TestLibrary.pas"
// ���������: "TestLibrary"
// ������� ������: "Archi Tests" MUID: (4D53DEED0062)

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

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
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_TestLibrary
 {$IfEnd} // NOT Defined(NoVCM)
 , Abstract Tests_TestLibrary
 , Abstract Archi Tests_TestLibrary
 , K294595323Suite
 , K275780190
 , K294595323
 , K327821495
 , K392696007
 , K361038156
 , K365838449
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
