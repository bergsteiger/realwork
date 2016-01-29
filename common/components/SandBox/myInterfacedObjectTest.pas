unit myInterfacedObjectTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "myInterfacedObjectTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::Core::TmyInterfacedObjectTest
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
 TmyInterfacedObjectTest = class(TTestCase)
 published
 // published methods
   procedure DoIt;
 end;//TmyInterfacedObjectTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  myInterfacedObject,
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TmyInterfacedObjectTest

procedure TmyInterfacedObjectTest.DoIt;
//#UC START# *516D4FDE0133_516D4FB9038C_var*
var
 l_O : TmyInterfacedObject;
 l_AnotherRef : TmyInterfacedObject;
 l_A : IUnknown;
 l_B : IUnknown;
//#UC END# *516D4FDE0133_516D4FB9038C_var*
begin
//#UC START# *516D4FDE0133_516D4FB9038C_impl*
 l_AnotherRef := nil;
 try
  l_O := TmyInterfacedObject.Create;
  try
   Check(l_O.RefCount = 1);
   l_A := l_O;
   Check(l_O.RefCount = 2);
   l_A := nil;
   Check(l_O.RefCount = 1);
   l_AnotherRef := l_O.Use;
   Check(l_O.RefCount = 2);
   l_B := l_O;
   Check(l_O.RefCount = 3);
  finally
   FreeAndNil(l_O);
  end;//try..finally
  Check(l_AnotherRef.RefCount = 2);
  l_B := nil;
  Check(l_AnotherRef.RefCount = 1);
 finally
  FreeAndNil(l_AnotherRef);
 end;//try..finally
//#UC END# *516D4FDE0133_516D4FB9038C_impl*
end;//TmyInterfacedObjectTest.DoIt

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TmyInterfacedObjectTest.Suite);

end.