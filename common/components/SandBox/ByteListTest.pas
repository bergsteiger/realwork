unit ByteListTest;

// ������: "w:\common\components\SandBox\ByteListTest.pas"
// ���������: "TestCase"
// ������� ������: "ByteListTest" MUID: (51DEE67C003A)
// ��� ����: "TByteListTest"

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , ByteList
;

type
 _ListType_ = TByteList;
 {$Include w:\common\components\SandBox\AtomicListTest.imp.pas}
 TByteListTest = class(_AtomicListTest_)
 end;//TByteListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *51DEE67C003Aimpl_uses*
 //#UC END# *51DEE67C003Aimpl_uses*
;

{$Include w:\common\components\SandBox\AtomicListTest.imp.pas}

initialization
 TestFramework.RegisterTest(TByteListTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
