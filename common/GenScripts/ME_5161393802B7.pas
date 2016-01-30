unit RefcountedTest;

// Модуль: "w:\common\components\SandBox\RefcountedTest.pas"
// Стереотип: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TRefcountedTest = class(TTestCase)
  public
   procedure DoIt;
 end;//TRefcountedTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , Refcounted
 , SysUtils
;

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

initialization
 TestFramework.RegisterTest(TRefcountedTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
