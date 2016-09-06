unit myReferenceCountGuardTest;

// Модуль: "w:\common\components\SandBox\myReferenceCountGuardTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TmyReferenceCountGuardTest" MUID: (516D58890258)

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TmyReferenceCountGuardTest = class(TTestCase)
  published
   procedure DoIt;
   procedure CheckWithClause;
 end;//TmyReferenceCountGuardTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , SysUtils
 , myReferenceCountGuard
 //#UC START# *516D58890258impl_uses*
 //#UC END# *516D58890258impl_uses*
;

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

initialization
 TestFramework.RegisterTest(TmyReferenceCountGuardTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
