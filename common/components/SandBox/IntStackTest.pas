unit IntStackTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "IntStackTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::ContainersTests::TIntStackTest
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
 TIntStackTest = {final} class(TTestCase)
 published
 // published methods
   procedure DoIt;
 end;//TIntStackTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  IntStack,
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TIntStackTest

procedure TIntStackTest.DoIt;
//#UC START# *5155CA8A02A6_5155CA4E0028_var*
const
 cEtalons : array [0..3] of integer = (10, 20, 3, 5);
var
 l_S : TIntStack;
 l_I : Integer;
//#UC END# *5155CA8A02A6_5155CA4E0028_var*
begin
//#UC START# *5155CA8A02A6_5155CA4E0028_impl*
 l_S := TIntStack.Create;
 try
  for l_I := Low(cEtalons) to High(cEtalons) do
   l_S.Push(cEtalons[l_I]);
  for l_I := High(cEtalons) downto Low(cEtalons) do
   Check(l_S.Pop = cEtalons[l_I]);
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *5155CA8A02A6_5155CA4E0028_impl*
end;//TIntStackTest.DoIt

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TIntStackTest.Suite);

end.