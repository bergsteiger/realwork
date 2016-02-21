unit IntegerListTest;

// ������: "w:\common\components\SandBox\IntegerListTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , IntegerList
;

type
 _ListType_ = TIntegerList;
 {$Include w:\common\components\SandBox\AtomicListTest.imp.pas}
 TIntegerListTest = class(_AtomicListTest_)
 end;//TIntegerListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include w:\common\components\SandBox\AtomicListTest.imp.pas}

initialization
 TestFramework.RegisterTest(TIntegerListTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
