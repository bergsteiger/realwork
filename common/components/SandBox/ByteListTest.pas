unit ByteListTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBoxTest"
// ������: "ByteListTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::FinalContainersTests::ByteListTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork,
  ByteList
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _ListType_ = TByteList;
 {$Include ..\SandBox\AtomicListTest.imp.pas}
 TByteListTest = class(_AtomicListTest_)
 end;//TByteListTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

{$Include ..\SandBox\AtomicListTest.imp.pas}


{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TByteListTest.Suite);
end.