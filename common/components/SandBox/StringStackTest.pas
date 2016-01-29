unit StringStackTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "StringStackTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::ContainersTests::TStringStackTest
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
 TStringStackTest = class(TTestCase)
 published
 // published methods
   procedure DoIt;
 end;//TStringStackTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  StringStack,
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TStringStackTest

procedure TStringStackTest.DoIt;
//#UC START# *5155CA990036_5155CA6F0058_var*
const
 cEtalons : array [0..3] of String = ('мама', 'мыла', 'раму', 'весело');
var
 l_S : TStringStack;
 l_I : Integer;
//#UC END# *5155CA990036_5155CA6F0058_var*
begin
//#UC START# *5155CA990036_5155CA6F0058_impl*
 l_S := TStringStack.Create;
 try
  for l_I := Low(cEtalons) to High(cEtalons) do
   l_S.Push(cEtalons[l_I]);
  for l_I := High(cEtalons) downto Low(cEtalons) do
   Check(l_S.Pop = cEtalons[l_I]);
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *5155CA990036_5155CA6F0058_impl*
end;//TStringStackTest.DoIt

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TStringStackTest.Suite);

end.