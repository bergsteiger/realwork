unit ServiceTest;

// Модуль: "w:\common\components\SandBox\ServiceTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\SandBox\sbtDefine.inc}

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

 function DoIt(anItem: TComponent): Boolean;
  {* Подитеративная функция для вызова L2MIterateableServiceIterateFAction из DoIter }
 //#UC START# *6211A607D3EF__var*
 //#UC END# *6211A607D3EF__var*
 begin
 //#UC START# *6211A607D3EF__impl*
  Result := true;
 //#UC END# *6211A607D3EF__impl*
 end;//DoIt

//#UC START# *551BC0D201CF_551962080380_var*
//#UC END# *551BC0D201CF_551962080380_var*
begin
 //#UC START# *551BC0D201CFiter*
 //#UC END# *551BC0D201CFiter*
 TIterateableService.Instance.IterateF(L2MIterateableServiceIterateFAction(@DoIt)
 //#UC START# *551BC0D201CFiterparam*
   , Application
 //#UC END# *551BC0D201CFiterparam*
 );
end;//TServiceTest.DoIter

initialization
 TestFramework.RegisterTest(TServiceTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
