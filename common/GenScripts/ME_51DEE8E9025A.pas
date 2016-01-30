unit Int64ListTest;

// Модуль: "w:\common\components\SandBox\Int64ListTest.pas"
// Стереотип: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , Int64List
;

type
 _ListType_ = TInt64List;
 {$Include AtomicListTest.imp.pas}
 TInt64ListTest = class(_AtomicListTest_)
 end;//TInt64ListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include AtomicListTest.imp.pas}

initialization
 TestFramework.RegisterTest(TInt64ListTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
