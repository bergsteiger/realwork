unit SandBoxTest_Emba_TestUnit;
 {* ����� ����������� ��������� }

// ������: "w:\common\components\SandBox\SandBoxTest_Emba_TestUnit.pas"
// ���������: "TestUnit"
// ������� ������: "Emba" MUID: (51643DEB0153)

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
 , ReallocMemTest
;
{$IfEnd} // Defined(nsTest)

end.
