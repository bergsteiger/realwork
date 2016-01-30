unit ServiceTest;

// ������: "w:\common\components\SandBox\ServiceTest.pas"
// ���������: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
 , Classes
;

type
 TServiceTest = class(TTestCase)
  public
   procedure DoIt;
   procedure DoIter;
 end;//TServiceTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , IterateableService
 , IterateableServiceProvider
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TServiceTest.DoIt;
//#UC START# *55196221027E_551962080380_var*
//#UC END# *55196221027E_551962080380_var*
begin
//#UC START# *55196221027E_551962080380_impl*
 DoIter;
//#UC END# *55196221027E_551962080380_impl*
end;//TServiceTest.DoIt

procedure TServiceTest.DoIter;
//#UC START# *551BC0D201CF_551962080380_var*
//#UC END# *551BC0D201CF_551962080380_var*
begin
//#UC START# *551BC0D201CF_551962080380_impl*
 !!! Needs to be implemented !!!
//#UC END# *551BC0D201CF_551962080380_impl*
end;//TServiceTest.DoIter

initialization
 TestFramework.RegisterTest(TServiceTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
