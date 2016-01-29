unit ServiceTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "ServiceTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::Core::ServiceTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  Classes,
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TServiceTest = class(TTestCase)
 public
 // public methods
   procedure DoIter;
     {* Сигнатура метода DoIter }
 published
 // published methods
   procedure DoIt;
 end;//TServiceTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  IterateableService,
  IterateableServiceProvider
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TServiceTest

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

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TServiceTest.Suite);

end.