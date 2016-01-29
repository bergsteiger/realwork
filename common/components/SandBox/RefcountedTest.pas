unit RefcountedTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "RefcountedTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::Core::TRefcountedTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TRefcountedTest = class(TTestCase)
 published
 // published methods
   procedure DoIt;
 end;//TRefcountedTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  Refcounted,
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TRefcountedTest

procedure TRefcountedTest.DoIt;
//#UC START# *516139A803D5_5161393802B7_var*
var
 l_A : TRefcounted;
 l_B : TRefcounted;
//#UC END# *516139A803D5_5161393802B7_var*
begin
//#UC START# *516139A803D5_5161393802B7_impl*
 l_A := TRefcounted.Create;
 try
  Check(l_A.RefCount = 1);
  l_B := l_A.Use;
  try
   Check(l_A.RefCount = 2);
   Check(l_B.RefCount = 2);
  finally
   FreeAndNil(l_B);
  end;//try..finally
  Check(l_A.RefCount = 1);
 finally
  FreeAndNil(l_A);
 end;//try..finally
//#UC END# *516139A803D5_5161393802B7_impl*
end;//TRefcountedTest.DoIt

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TRefcountedTest.Suite);

end.