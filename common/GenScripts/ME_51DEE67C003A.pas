unit ByteListTest;

// Модуль: "w:\common\components\SandBox\ByteListTest.pas"
// Стереотип: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , ByteList
;

type
 _ListType_ = TByteList;
 {$Include AtomicListTest.imp.pas}
 TByteListTest = class(_AtomicListTest_)
 end;//TByteListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
;

{$Include AtomicListTest.imp.pas}

initialization
 TestFramework.RegisterTest(TByteListTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
