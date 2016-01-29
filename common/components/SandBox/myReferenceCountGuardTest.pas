unit myReferenceCountGuardTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "myReferenceCountGuardTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::Core::TmyReferenceCountGuardTest
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
 TmyReferenceCountGuardTest = class(TTestCase)
 published
 // published methods
   procedure DoIt;
   procedure CheckWithClause;
 end;//TmyReferenceCountGuardTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  SysUtils,
  myReferenceCountGuard
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TmyReferenceCountGuardTest

procedure TmyReferenceCountGuardTest.DoIt;
//#UC START# *516D58B001F4_516D58890258_var*
var
 l_G : ImyReferenceCountGuard;
 l_Another : ImyReferenceCountGuard;
//#UC END# *516D58B001F4_516D58890258_var*
begin
//#UC START# *516D58B001F4_516D58890258_impl*
 l_G := TmyReferenceCountGuard.Make;
 Check(l_G.GetRefCount = 1);
 l_Another := l_G;
 Check(l_G.GetRefCount = 2);
 l_G := nil;
 Check(l_Another.GetRefCount = 1);
 l_Another := nil;
//#UC END# *516D58B001F4_516D58890258_impl*
end;//TmyReferenceCountGuardTest.DoIt

procedure TmyReferenceCountGuardTest.CheckWithClause;
//#UC START# *516D61EF0340_516D58890258_var*
var
 l_G : ImyReferenceCountGuard;
//#UC END# *516D61EF0340_516D58890258_var*
begin
//#UC START# *516D61EF0340_516D58890258_impl*
 l_G := TmyReferenceCountGuard.Make;
 Check(l_G.GetRefCount = 1);
 with l_G do
 begin
  Check(GetRefCount = 1);
  Check(GetRefCount = 1);
 end;//with l_G
 Check(l_G.GetRefCount = 1);
//#UC END# *516D61EF0340_516D58890258_impl*
end;//TmyReferenceCountGuardTest.CheckWithClause

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TmyReferenceCountGuardTest.Suite);

end.