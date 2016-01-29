unit Int64ListTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "Int64ListTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::FinalContainersTests::Int64ListTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork,
  Int64List
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _ListType_ = TInt64List;
 {$Include ..\SandBox\AtomicListTest.imp.pas}
 TInt64ListTest = class(_AtomicListTest_)
 end;//TInt64ListTest
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
 TestFramework.RegisterTest(TInt64ListTest.Suite);
end.