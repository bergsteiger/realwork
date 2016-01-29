unit IntegerListTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "IntegerListTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::FinalContainersTests::IntegerListTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork,
  IntegerList
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _ListType_ = TIntegerList;
 {$Include ..\SandBox\AtomicListTest.imp.pas}
 TIntegerListTest = class(_AtomicListTest_)
 end;//TIntegerListTest
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
 TestFramework.RegisterTest(TIntegerListTest.Suite);
end.