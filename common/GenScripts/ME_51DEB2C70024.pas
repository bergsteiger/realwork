unit SandBoxTest_FinalContainersTests_TestUnit;

// ������: "w:\common\components\SandBox\SandBoxTest_FinalContainersTests_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "FinalContainersTests" MUID: (51DEB2C70024)

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , Int64ListTest
 , IntegerListTest
 , IUnknownRefListTest
 , ByteListTest
;
{$IfEnd} // Defined(nsTest)

end.
