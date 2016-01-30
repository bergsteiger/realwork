unit IntegerListTest;

// Модуль: "w:\common\components\SandBox\IntegerListTest.pas"
// Стереотип: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , IntegerList
;

type
 _ListType_ = TIntegerList;
 {$Include AtomicListTest.imp.pas}
 TIntegerListTest = class(_AtomicListTest_)
 end;//TIntegerListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include AtomicListTest.imp.pas}

initialization
 TestFramework.RegisterTest(TIntegerListTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
